{% for role in salt['grains.get']('roles', []) %}
{% if role %}
  'role:{{ role }}':
    - match: grain
    - {{ role }}

{% endif %}
{% endfor %}
