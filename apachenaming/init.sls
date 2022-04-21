
######################################################
# install apache webserver in centos, start service, changePage
# 
###################################################### 
#install apache
apache-pkg:
  pkg:
    - installed
    - name: httpd
  service:
    - running 
    - name: httpd
    - require:
      - pkg: apache-pkg
      
#change page
change_page:
  cmd.run:
    - name: sed -i 's/Apache2 Ubuntu/LuchoDelorenzi/g' /var/www/html/index.html
    - require:
      - apache-pkg
      
