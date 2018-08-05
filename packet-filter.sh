#!/bin/bash

tmpfile=`mktemp /tmp/packetfilter.XXXXX`
# Facebook ASN
ASN=32934
lines=`whois -h riswhois.ripe.net -- -F -K -i $ASN | grep -E 'route[6]?' | awk '{ print "block return on en0 from any to", $2 };'`

cat > $tmpfile <<EOF
set block-policy return
set skip on lo0

$lines
EOF

echo "Updating packetfilter rules (enter your admin passwd)"
sudo cp $tmpfile /etc/pf.anchors/block-facebook
if grep -qv 'anchor "block-facebook"' "$tmpfile"; then
echo "Setting up packet filter inclusion (enter your admin passwd)"
sudo bash -c "cat >> /etc/pf.conf" << 'EOF'

anchor "block-facebook"
load anchor "block-facebook" from "/etc/pf.anchors/block-facebook"
EOF
fi

echo "reloading packetfilter rules"
sudo pfctl -d
echo "enabling packetfiltering"
sudo pfctl -f /etc/pf.conf
sudo pfctl -e
echo "new rules:"
sudo pfctl -a block-facebook -s rules
