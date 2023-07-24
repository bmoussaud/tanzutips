kubectl patch  app $1 -p '{"metadata":{"finalizers":[]}}' --type=merge
