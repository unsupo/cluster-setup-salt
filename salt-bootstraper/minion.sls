

include:
  - salt-bootstraper.bootstraper

minion_installer_run:
  cmd.run:
    - name: sudo sh /root/install_salt.sh -P
    - requires:
      - cmd: installer_download
    - unless:
      {% if grains.get('os') == 'Ubuntu' %}
      - grep latest /etc/apt/sources.list.d/saltstack.list
      {% endif %}

minion_pkgs:
  pkg.installed:
    - pkgs:
      - salt-minion
    - require:
      - cmd: minion_installer_run

salt_minion_service:
  service.running:
    - name: 'salt-minion'
    - enable: True
    - require:
      - pkg: minion_pkgs
    - watch:
      - file: salt_minion_id_conf
      - file: salt_minion_conf

salt_minion_id_conf:
  file.managed:
    - name: /etc/salt/minion_id
    - contents: {{ salt['cmd.run']('hostname') }}

salt_minion_conf:
  file.managed:
    - source: salt://salt-bootstraper/file/minion_overrides.conf.j2
    - name: /etc/salt/minion.d/minion_overrides.conf
    - makedirs: True
    - template: jinja
    - defaults:
        master_ip: {{ salt['cmd.run']('cat /root/master_ip') }}
    #     minion_id:
