production:
  {% for role in salt['grains.get']('roles', []) %}
  'roles:{{ role }}':
    - match: grain
    - {{ role }}
  {% endfor %}
