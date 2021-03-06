DEVICE := $(or ${CONNECTIQ_DEVICE}, fenix5plus)
KEY := $(or ${GARMIN_DEVELOPER_KEY}, "${HOME}/.garmin/developer_key")

all:
	monkeyc -d ${DEVICE} -f monkey.jungle -o bin/BeerpongWidget.prg -y ${KEY}

run: all
	@mkdir -p bin
	monkeydo bin/BeerpongWidget.prg ${DEVICE}

release:
	monkeyc -e -f monkey.jungle -o BeerpongWidget.iq -y ${KEY}
