docker build -t frank40609/multi-client:latest -t frank40609/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t frank40609/multi-worker:latest -t frank40609/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -f frank40609/multi-server:latest -t frank40609/multi-server:$SHA -f ./server/Dockerfile ./server
docker push frank40609/multi-client:latest
docker push frank40609/multi-worker:latest
docker push frank40609/multi-server:latest
docker push frank40609/multi-client:$SHA
docker push frank40609/multi-worker:$SHA
docker push frank40609/multi-server:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=frank40609/multi-server:$SHA
kubectl set image deployments/client-deployment client=frank40609/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=frank40609/multi-worker:$SHA