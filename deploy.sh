docker build -t livemoneky1300/multi-client:latest -t livemoneky1300/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t livemoneky1300/multi-server:latest -t livemoneky1300/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t livemoneky1300/multi-worker:latest -t livemoneky1300/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push livemoneky1300/multi-client:latest 
docker push livemoneky1300/multi-server:latest 
docker push livemoneky1300/multi-worker:latest 

docker push livemoneky1300/multi-client:$SHA
docker push livemoneky1300/multi-server:$SHA
docker push livemoneky1300/multi-worker:$SHA


kubctl apply -f k8s
kubctl set image deployments/server-deployment server=livemoneky1300/multi-server:$SHA
kubctl set image deployments/client-deployment server=livemoneky1300/multi-client:$SHA
kubctl set image deployments/worker-deployment server=livemoneky1300/multi-worker:$SHA