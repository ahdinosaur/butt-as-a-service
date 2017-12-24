production:
  {% set roles = salt['grains.get']('roles', []) -%}
  {% for role in roles -%}
  'roles:{{ role }}':
    - match: grain
    {% if role == 'master' -%}
    - salt.master
    {% elif role == 'minion' -%}
    - salt.minion
    {% else -%}
    - {{ role }}
    {% endif %}

  {% endfor %}
