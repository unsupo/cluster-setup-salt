{% set revision = salt['cmd.run']('grep Revision /proc/cpuinfo') %}
{% set hostname = salt['grains.get']('id')+'-'%}
# https://www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes/README.md
{% if revision == '000e' %}
  {% set hostname += "2B" %}
{% elif revision == 'a020d3'  %}
  {% set hostname += "3Bp" %}
{% elif revision == '9000c1'  %}
  {% set hostname += "ZeroW" %}
{% else %}
  {% set hostname += "UKN" %}
{% endif %}


setup_hostname_hosts:
  cmd.run:
    - name: sudo hostname {{ hostname }} && sed -i 's/raspberrypi/{{ hostname }}/g' /etc/hosts
    - unless: grep {{ hostname }} /etc/hosts

setup_hostname:
  file.managed:
    - name: /etc/hostname
    - contents: {{ hostname }}
    - unless: grep {{ hostname }} /etc/hostname
    - require:
      - cmd: setup_hostname_hosts

installer_download:
  file.managed:
    - source: https://bootstrap.saltstack.com
    - name: /root/install_salt.sh
    - skip_verify: True
    - creates: /root/install_salt.sh
    - require:
      - file: setup_hostname
