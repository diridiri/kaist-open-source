rm ~/hubblemon/collect_server/nohup.out
rm ~/hubblemon/collect_client/nohup.out

pkill python 

python3 manage.py migrate

nohup python3 ~/hubblemon/collect_server/run_server.py &
nohup python3 ~/hubblemon/collect_server/run_listener.py &
nohup python3 ~/hubblemon/collect_client/run_client.py &
python3 ~/hubblemon/manage.py runserver 0.0.0.0:8008
