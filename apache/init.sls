######################################################
# Name: apache.sls
#
# Description: install apache
#
# verified OS: Ubuntu 14.04, CentOS 6.5 0penSuse Leap
#
# usage:
# salt state.sls apache
#
######################################################
# set up the variables  
{% set apache_html = salt['pillar.get']('apache:html', '/var/www/html') %}

######################################################
# setup os specific references
# 
###################################################### 
{% if grains['os_family'] == 'RedHat' %}
  {% set apache = 'httpd' %}
  {% set apache_user = 'apache' %}
  {% set apache_group = 'apache' %}
  {% set apache_conf_dir = '/etc/httpd' %}
  {% set apache_def_site_file = salt['pillar.get']('apache:apache_def_site_file', '/etc/httpd/conf/httpd.conf') %}
{% elif grains['os_family'] == 'Debian' %}
  {% set apache = 'apache2' %}
  {% set apache_user = 'www-data' %}
  {% set apache_group = 'www-data' %}
  {% set apache_conf_dir = '/etc/apache2' %}
  {% set apache_def_site_file = salt['pillar.get']('apache:apache_def_site_file', '/etc/apache2/sites-available/000-default.conf') %}
{% elif grains['os_family'] == 'Suse' %}
  {% set apache = 'apache2' %}
  {% set apache_html = '/srv/www/' %}
  {% set apache_user = 'wwwrun' %}
  {% set apache_group = 'www' %}
  {% set apache_conf_dir = '/etc/apache2' %}
  {% set apache_def_site_file = salt['pillar.get']('apache:apache_def_site_file', '/etc/apache2/httpd.conf') %}
{% endif %}


######################################################
# install apache webserver and start service
# 
###################################################### 
#install apache
apache-pkg:
  pkg:
    - installed
    - name: {{ apache }} 
  service:
    - running 
    - name: {{ apache }}
    - require:
      - pkg: apache-pkg
      
#change page
change_page:
  cmd.run:
    - name: sed -i 's/Apache2 Ubuntu/LuchoDelorenzi/g' /var/www/html/index.html
    - require:
      - apache-pkg
