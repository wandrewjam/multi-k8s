docker build -t wandrewjam/multi-client:latest -t wandrewjam/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wandrewjam/multi-server:latest -t wandrewjam/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wandrewjam/multi-worker:latest -t wandrewjam/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push wandrewjam/multi-client:latest
docker push wandrewjam/multi-server:latest
docker push wandrewjam/multi-worker:latest

docker push wandrewjam/multi-client:$SHA
docker push wandrewjam/multi-server:$SHA
docker push wandrewjam/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wandrewjam/multi-server:$SHA
kubectl set image deployments/client-deployment client=wandrewjam/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=wandrewjam/multi-worker:$SHA
