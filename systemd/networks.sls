{% for unittype, units in salt['pillar.get']('networkd', {}).items()  %}
{% for unit, unitconfig in units.items() %}

/etc/systemd/network/{{ unit }}.{{ unittype }}:
  file.managed:
    - template: jinja
    - source: salt://systemd/unit.jinja
    - context:
        config: {{ unitconfig }}
    - watch_in:
      - service: systemd-networkd
{% endfor %}
{% endfor %}

systemd-networkd:
  service.running:
    - enable: True
    - reload: True

