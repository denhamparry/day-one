#!/bin/bash
# shellcheck disable=SC2034 # Unused variables left for readability but used in demo magic

echo "Check for running pods"
if kubectl get pods | grep -q .; then
    kubectl get pods
    read -r -p "There are running pods, quit? (y/n): " confirm
    if [[ $confirm == [yY] ]]; then
        echo "Exiting..."
        exit
    fi
else
    echo "No running pods found."
fi

########################
# include the magic
########################
. demo-magic.sh

TURQUOISE_COLOR="\033[38;2;0;245;214m"           # RGB for #00f5d6
LIGHT_TURQUOISE_COLOR="\033[38;2;208;253;242m"   # RGB for #d0fdf2
PINK_COLOR="\033[38;2;255;62;181m"               # RGB for #ff3eb5
YELLOW_COLOR="\033[38;2;240;245;0m"              # RGB for #f0f500
RESET_COLOR="\033[0m"  

CLEAR_AFTER=true                                # Clear screen after each command
DEMO_CMD_COLOR=$TURQUOISE_COLOR                 # Command color
DEMO_COMMENT_COLOR=$PINK_COLOR                  # Comment color
DEMO_PROMPT="$ "                                # Change to customize the prompt symbol
NO_WAIT=false                                   # Set to true to execute commands instantly without typing delay
TYPE_SPEED=100                                  # Speed in milliseconds per character (1 is slow, 100 is fast)

# hide the evidence
clear

p "# Show that we're running a single node cluster"
pei "kubectl get nodes"

# Clean up the screen
pe "clear"

p "# Provide a demo of am-i-isolated"
pei "curl -sL https://edera.link/aiibash | bash"

# Clean up the screen
pe "clear"

p "# Apply Leaky Vessel"
pei "kubectl apply -f kubernetes/leaky-vessel.yaml"

p "# But what is Leaky Vessel?"
pei "cat kubernetes/leaky-vessel.yaml"

p "# What does Leaky Vessel do? (sleep.sh snoring out to the logs)"
pei "kubectl logs leaky-vessel"

# Clean up the screen
pe "clear"

p "# Apply the Raider"
pei "kubectl apply -f kubernetes/raider.yaml"

p "# But what is Raider?"
pei "cat kubernetes/raider.yaml"

p "# And what does Raider do? (run workloads with privileges)"
pei "cat kubernetes/raider.yaml | grep -E 'hostPID: true|privileged: true'"

# Clean up the screen
pe "clear"

p "# What can we do with Raider?"
pei "kubectl exec -it raider -- ps faux"

# Clean up the screen
pe "clear"

p "# Get the process ID with some bash"
pei "export LEAKY_VESSEL_PID=\$(kubectl exec -it raider -- /bin/sh -c \"ps faux | grep '/bin/sh /sleep.sh' | awk '{print \\\$2}' | head -n 1 | tr -d '\\\\r\\\\n' \") && echo \$LEAKY_VESSEL_PID"

p "# View the environment variables within Leaky Vessel"
pei "kubectl exec -it raider -- /bin/sh -c \"cat /proc/\$LEAKY_VESSEL_PID/environ | tr '\\\\0' '\\\\n'\""

p "# View the secrets variables within Leaky Vessel"
pei "kubectl exec -it raider -- /bin/sh -c \"cat /proc/\$LEAKY_VESSEL_PID/environ | tr '\\\\0' '\\\\n' | grep 'SECRET'\""

# Clean up the screen
pe "clear"

p "# So how so we solve a problem like Leaky Vessel? (e.g. protect our critical workloads?) DELETE IT!"
pei "kubectl delete pods leaky-vessel --force --grace-period=0 > /dev/null 2>&1"

# Clean up the screen
pe "clear"

# Apply the Edera RuntimeClass
p "# Apply the Edera Runtime Class"
pei "kubectl apply -f kubernetes/runtime-edera.yaml"

# Clean up the screen
pe "clear"

p "# Apply Hardened Vessel"
pei "kubectl apply -f kubernetes/hardened-vessel.yaml"

p "# But what is the difference between Leaky Vessel and Hardened Vessel?"
pei "diff --color kubernetes/leaky-vessel.yaml kubernetes/hardened-vessel.yaml"

p "# What does Hardened Vessel do? (sleep.sh snoring out to the logs)"
pei "kubectl logs hardened-vessel"

# Clean up the screen
pe "clear"

p "# Lets replay the attack, what can we do with Raider?"
pei "kubectl exec -it raider -- ps faux"

p "# I can't see Leaky Vessel?"
pei "kubectl exec -it raider -- ps faux | grep sleep.sh"

# Clean up the screen
pe "clear"
