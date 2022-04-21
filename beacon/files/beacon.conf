# Name: beacon.conf
# Description: Beacon to deploy to minion to protect changes to index.html

beacons:
  inotify:
    - files: 
        /var/www/sam/index.html:
          mask: 
            - modify
            - close_write
    - disable_during_state_run: True
