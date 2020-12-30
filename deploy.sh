docker build -t ishu22g/multi-client:latest -t ishu22g/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ishu22g/multi-server:latest -t ishu22g/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ishu22g/multi-worker:latest -t ishu22g/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ishu22g/multi-client:latest
docker push ishu22g/multi-server:latest
docker push ishu22g/multi-worker:latest

docker push ishu22g/multi-client:$SHA
docker push ishu22g/multi-server:$SHA
docker push ishu22g/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ishu22g/multi-client:$SHA
kubectl set image deployments/server-deployment server=ishu22g/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ishu22g/multi-worker:$SHA