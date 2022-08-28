cd $(dirname $0)

for region in $(echo fr-par-1; echo fr-par-2; echo nl-ams-2; echo pl-waw-1); do
	for i in $(seq 3); do
		scw instance server create type=PRO2-L zone=$region image=debian_bullseye root-volume=b:10G additional-volumes.0=b:10G name=compute-$region-$i ip=new cloud-init=@bootscript.sh
	done
done
