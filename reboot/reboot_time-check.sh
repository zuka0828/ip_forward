#!/bin/sh

THD=20000
LOOP=1500

COUNTER=reboot-count
LOG=us.log

cd /root/ip_forward

if [ ! -f ${COUNTER} ]; then
	echo 0 > ${COUNTER}
fi
count=$(cat ${COUNTER})

n=1
us_max=0
while [ ${n} -le ${LOOP} ]; do
	us=$(./ip_forward_system-proc)
	if [ ${us} -gt ${us_max} ]; then
		us_max=${us}
	fi

	if [ ${us_max} -gt ${THD} ]; then
		echo "${0}: ${us_max} > ${THD}"
		echo ${us_max} >> ${LOG}
		exit 0
	fi
	n=$(expr ${n} + 1)
done

if [ -f ./reboot ]; then
	expr ${count} + 1 > ${COUNTER}
	echo ${us_max} >> ${LOG}
	echo "${0}: Rebooting (count=${count}, us_max=${us_max})"
	reboot
else
	echo "${0}: No reboot flag, exiting"
fi
