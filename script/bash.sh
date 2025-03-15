turn_off () {
curl \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI0NDFkNWYyZTk5MTg0Mzg2ODQ3ZWEyODE5YmVmNjI3OCIsImlhdCI6MTc0MjA0MTc3MSwiZXhwIjoyMDU3NDAxNzcxfQ.4CV32SHoTe09OVRyvDNiSDlv8BAtlg8m4Tdp0okHoQg" \
  -H "Content-Type: application/json" -d '{"entity_id": "switch.mss210_f100_outlet"}'\
	http://localhost:8123/api/services/switch/turn_off
}

turn_on () {
curl \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI0NDFkNWYyZTk5MTg0Mzg2ODQ3ZWEyODE5YmVmNjI3OCIsImlhdCI6MTc0MjA0MTc3MSwiZXhwIjoyMDU3NDAxNzcxfQ.4CV32SHoTe09OVRyvDNiSDlv8BAtlg8m4Tdp0okHoQg" \
  -H "Content-Type: application/json" -d '{"entity_id": "switch.mss210_f100_outlet"}'\
	http://localhost:8123/api/services/switch/turn_on
}

cat < /dev/ttyACM1 > /tmp/serial &

i=0
offset=0

while :
do
  sleep 0.1;
  cranks=$(cat /tmp/serial | grep -a "Cranked" | wc -l)
  diff=$(($cranks-$offset))
  echo $(($diff * 8)) > /dev/ttyACM0
  echo $diff
  if [ $diff -gt 15 ]; then
		turn_on
	else
		turn_off
	fi
  i=$(($i+1))
  if [ $(($i % 4)) -eq 0 ] && [ $diff -gt 0 ]; then
    offset=$(($offset + 1))
  elif [ $(($i % 4)) -eq 0 ] && [ $diff -lt 0 ]; then
    > /tmp/serial
    offset=0
	fi
done;
