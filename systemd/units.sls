{% for unittype, units in pillar['systemd'].iteritems()  %}
{% for unit, unitconfig in units.iteritems() %}

/lib/systemd/system/{{ unit }}.{{ unittype }}:
  file.managed:
    - template: jinja
    - source: salt://systemd/unit.jinja
    - context:
        config: {{ unitconfig }}
    - watch_in:
      - cmd: reload_systemd_configuration

{% endfor %}
{% endfor %}

reload_systemd_configuration:
  cmd.wait:
    - name: systemctl reload
