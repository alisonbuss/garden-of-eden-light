#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Installation script.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/start-divine-creation.sh
# @example:
#       $ bash run-scripts.sh --file scripts-all.json
#   OR
#       $ bash run-scripts.sh -f scripts-dev.json
#-------------------------------------------------------------#

# Initialize the variable that will store the JSON file name:
JSON_FILE="";

# Start processing the arguments passed to the script:
while [[ "$#" -gt 0 ]]; do
    params="$1";  # The parameter name (e.g., --file).
    value="$2";   # The value associated with the parameter (e.g., scripts-all.json).

    case $params in
        # Accepts --file or -f as a valid parameter:
        *--file*|*-f*) {
            # Check if the value is missing or is another flag:
            if [[ -z "$value" || "$value" == --* ]]; then
                echo "Error: You need to provide a value for $params";
                exit 1;
            fi
            # Assign the value to JSON_FILE and shift by two arguments:
            JSON_FILE="$value";
            shift 2;
        };;
        # If the parameter starts with a dash but is unrecognized:
        -*) {
            echo "Unknown option: $params";
            exit 1;
        };;
        # If an unexpected argument is passed:
        *) {
            echo "Unexpected argument: $params";
            exit 1;
        };;
    esac
done

# Check if the JSON_FILE variable was defined:
if [[ -z "$JSON_FILE" ]]; then
    echo "use: $0 --file <file_name>";
    exit 1;
fi

# Update the package list:
sudo apt update;

# Diferenças entre `which` e `command -v`:
#
# | Critério           | `which`                            | `command -v`                       |
# | ------------------ | ---------------------------------- | ---------------------------------- |
# | Disponibilidade    | Nem sempre instalado por padrão    | Embutido no shell (mais confiável) |
# | Portabilidade      | Menos portátil                     | Mais portátil                      |
# | Comportamento      | Pode falhar em shells mais simples | Funciona até em scripts POSIX      |
# | Recomendação atual | Menos recomendada                  | **Mais recomendada**               |
#
# Errado:
#
# if ! which jq >/dev/null; then
#
# Certo:
if ! command -v jq >/dev/null 2>&1; then
    # Install the 'jq' utility if not already installed (used to process JSON):
    sudo apt install -y jq;
fi

# Get all scripts that should be executed:
SCRIPTS=($(jq -r '.scripts[] | select(.execute == true) | .script' "$JSON_FILE"));

# Get total number of scripts:
TOTAL=${#SCRIPTS[@]};

cat "./files/header.txt";

# Execute each script where ("execute": true):
for i in "${!SCRIPTS[@]}"; do
    INDEX=$((i + 1));
    SCRIPT="${SCRIPTS[$i]}";
    echo "Running [$INDEX/$TOTAL]: $SCRIPT...";
    bash "./src/scripts/$SCRIPT";  # Execute the listed script...
done

# Exit the script successfully!!!
exit 0;
