docker build -t ahrav/multi-client:latest -t ahrav/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ahrav/multi-server:latest -t ahrav/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ahrav/multi-worker:latest -t ahrav/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ahrav/multi-client:latest
docker push ahrav/multi-server:latest
docker push ahrav/multi-worker:latest
docker push ahrav/multi-client:$SHA
docker push ahrav/multi-server:$SHA
docker push ahrav/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ahrav/multi-server$SHA
kubectl set image deployments/client-deployment client=ahrav/multi-client$SHA
kubectl set image deployments/worker-deployment worker=ahrav/multi-worker$SHA