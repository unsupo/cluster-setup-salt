{% set revision = salt['cmd.run']('grep Revision /proc/cpuinfo').split(": ")[1].strip() %}
{% set hostname = salt['grains.get']('id')+'-' %}
# https://www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes/README.md
{% if revision == '000e' %}
  {% set hostname = hostname + "2B" %}
{% elif revision == 'a020d3'  %}
  {% set hostname = hostname + "3Bp" %}
{% elif revision == '9000c1'  %}
  {% set hostname = hostname + "ZeroW" %}
{% elif revision == 'a03111'  %}
  {% set hostname = hostname + "4B-1GB" %}
{% elif revision == 'b03111'  %}
  {% set hostname = hostname + "4B-2GB" %}
{% elif revision == 'c03111'  %}
  {% set hostname = hostname + "4B-4GB" %}
{% else %}
  {% set hostname = hostname + "UKN" %}
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
