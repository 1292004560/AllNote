#!/bin/sh
su - oracle <<EON
rman target/<< EOF
list archivelog all;
EOF
EON
