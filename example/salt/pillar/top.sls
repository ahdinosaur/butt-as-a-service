production:
  '*':
    - agents
  {% set roles = salt['grains.get']('roles', []) -%}
  {% for role in roles -%}
  'roles:{{ role }}':
    - match: grain
    - {{ role }}
  {% endfor -%}
