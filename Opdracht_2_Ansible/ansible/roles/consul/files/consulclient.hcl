lastLine=`tail -1 /etc/consul.d/consul.hcl`
if [ lastLine!="bind_addr = \"10.0.0.12\"" ]
then

retry_join = ["10.0.0.10"]
bind_addr = "10.0.0.12"
EOF
fi