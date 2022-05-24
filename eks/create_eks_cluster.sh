#!/bin/bash
set -x 

export CLUSTER_NAME=${CLUSTER_NAME:-tap-demo}
export NODE_NUMBER=${NODE_NUMBER:-2}
export NODE_TYPE=${NODE_TYPE:-m5.xlarge}

echo "CREATE new CLUSTER ${CLUSTER_NAME} with ${NODE_NUMBER} node(s) using the ${NODE_TYPE} model"

# Create EKS cluster role
export CLUSTER_SERVICE_ROLE=$(aws iam create-role --role-name "${CLUSTER_NAME}-eks-role" --assume-role-policy-document='{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Service":"eks.amazonaws.com"},"Action": "sts:AssumeRole"}]}' --output text --query 'Role.Arn')
aws iam attach-role-policy --role-name "${CLUSTER_NAME}-eks-role" --policy-arn arn:aws:iam::aws:policy/AmazonEKSServicePolicy
aws iam attach-role-policy --role-name "${CLUSTER_NAME}-eks-role" --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy

# Create VPC
export STACK_ID=$(aws cloudformation create-stack --stack-name ${CLUSTER_NAME} --template-url https://amazon-eks.s3.us-west-2.amazonaws.com/cloudformation/2020-10-29/amazon-eks-vpc-private-subnets.yaml --output text --query 'StackId')
aws cloudformation wait stack-create-complete --stack-name ${CLUSTER_NAME}
export SECURITY_GROUP=$(aws cloudformation describe-stacks --stack-name ${CLUSTER_NAME} --query "Stacks[0].Outputs[?OutputKey=='SecurityGroups'].OutputValue" --output text)
export SUBNET_IDS=$(aws cloudformation describe-stacks --stack-name ${CLUSTER_NAME} --query "Stacks[0].Outputs[?OutputKey=='SubnetIds'].OutputValue" --output text)

# Create EKS cluster
aws eks create-cluster --name ${CLUSTER_NAME} --kubernetes-version 1.21 --role-arn "${CLUSTER_SERVICE_ROLE}" --resources-vpc-config subnetIds="${SUBNET_IDS}",securityGroupIds="${SECURITY_GROUP}"
aws eks wait cluster-active --name ${CLUSTER_NAME}

# Create EKS worker node role
export WORKER_SERVICE_ROLE=$(aws iam create-role --role-name "${CLUSTER_NAME}-eks-worker-role" --assume-role-policy-document='{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Service":"ec2.amazonaws.com"},"Action": "sts:AssumeRole"}]}' --output text --query 'Role.Arn')
aws iam attach-role-policy --role-name "${CLUSTER_NAME}-eks-worker-role" --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
aws iam attach-role-policy --role-name "${CLUSTER_NAME}-eks-worker-role" --policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
aws iam attach-role-policy --role-name "${CLUSTER_NAME}-eks-worker-role" --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly

# Create EKS worker nodes
aws eks create-nodegroup --cluster-name ${CLUSTER_NAME} --kubernetes-version 1.21 --nodegroup-name "${CLUSTER_NAME}-node-group" --disk-size 500 --scaling-config minSize=${NODE_NUMBER},maxSize=${NODE_NUMBER},desiredSize=${NODE_NUMBER} --subnets $(echo $SUBNET_IDS | sed 's/,/ /g') --instance-types ${NODE_TYPE} --node-role ${WORKER_SERVICE_ROLE}
aws eks wait nodegroup-active --cluster-name ${CLUSTER_NAME} --nodegroup-name ${CLUSTER_NAME}-node-group