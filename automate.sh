terraform output generated_key > example2.pem
chmod 700 example2.pem
IP=`terraform output ip`
echo "ssh ubuntu@$IP -i ./example2.pem" > example2.sh
chmod +x example2.sh