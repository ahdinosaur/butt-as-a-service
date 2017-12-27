{% set roles = salt['grains.get']('roles', []) %}
{% for role in roles %}

{% if role == 'master' or role == 'minion' %}
pip:
  pkg.installed:
    - pkgs:
      - build-essential
      - python-setuptools
      - python-dev
      - python-pip
{% endif %}

{% if role == 'master' %}
wheel:
  pip.installed:
    - require:
      - pkg: pip

shade:
  pip.installed:
    - require:
      - pip: wheel

gitfs:
  pkg.installed:
    - pkgs:
      - git 
      - python-pygit2
{% endif %}

{% endfor %}
