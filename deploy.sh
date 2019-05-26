docker build -t livemoneky1300/multi-client:latest -t livemoneky1300/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t livemoneky1300/multi-server:latest -t livemoneky1300/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t livemoneky1300/multi-worker:latest -t livemoneky1300/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push livemoneky1300/multi-client:latest 
docker push livemoneky1300/multi-server:latest 
docker push livemoneky1300/multi-worker:latest 

docker push livemoneky1300/multi-client:$SHA
docker push livemoneky1300/multi-server:$SHA
docker push livemoneky1300/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=livemoneky1300/multi-server:$SHA
kubectl set image deployments/client-deployment client=livemoneky1300/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=livemoneky1300/multi-worker:$SHA