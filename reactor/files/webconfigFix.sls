# Name: webconfigFix.sls
# Used to fix index.html in the event a modification is made

# Sleep to give time for me to demo
sleep_20:
  cmd.run:
    - name: sleep 20

# Copy the file to the minion
deploy_index_html:
  file.managed:
    - name: /var/www/html/index.html
    - source: salt://webconfig/files/index.html.jinja
    - template: jinja
    - require:
      - sleep 20
      
# Restart the apache service
restart_httpd:
  service.running:
    - name: httpd
      watch:
      - file: deploy_index_html
