{% set roles = salt['grains.get']('roles', []) %}
{% for role in roles %}

{% if role == 'master' or role == 'minion' %}
python-pip:
  pkg.installed:
    - pkgs:
      - build-essential
      - python-setuptools
      - python-dev
      - python-pip
{% endif %}

{% if role == 'master' %}
python-wheel:
  pip.installed:
    - require:
      - pkg: python-pip

python-shade:
  pip.installed:
    - require:
      - pip: python-wheel

gitfs:
  pkg.installed:
    - pkgs:
      - git 
      - python-pygit2
{% endif %}

{% endfor %}
