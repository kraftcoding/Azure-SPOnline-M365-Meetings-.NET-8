#!/bin/bash

# ================================
# CONFIGURATION
# ================================
RG_NAME="rg-dev-meetings"
LOCATION="westeurope"
TEMPLATE_FILE="files/main.bicep"
PARAMS_FILE="files/params/dev.json"

# ================================
# ACTION MENU
# ================================
echo "======================================"
echo "        INFRA DEPLOYMENT SCRIPT"
echo "======================================"
echo ""
echo "1) Create/update environment"
echo "2) Delete environment and recreate"
echo "3) Exit"
echo ""
read -p "Select an option: " OPTION

# ================================
# FUNCTION: CREATE RESOURCE GROUP
# ================================
create_rg() {
    echo "🔍 Checking if Resource Group '$RG_NAME' exists..."
    RG_EXISTS=$(az group exists --name $RG_NAME)

    if [ "$RG_EXISTS" = "false" ]; then
        echo "📦 Creating Resource Group '$RG_NAME'..."
        az group create --name $RG_NAME --location $LOCATION
    else
        echo "✔️ The Resource Group already exists"
    fi
}

# ================================
# FUNCTION: DELETE RESOURCE GROUP
# ================================
delete_rg() {
    echo "⚠️ Deleting Resource Group '$RG_NAME'..."
    az group delete --name $RG_NAME --yes --no-wait
    echo "⏳ Deletion started. Wait a few minutes before recreating."
}

# ================================
# FUNCTION: DEPLOY INFRASTRUCTURE
# ================================
deploy_infra() {
    echo "🚀 Starting deployment..."
    az deployment group create \
        --resource-group $RG_NAME \
        --template-file $TEMPLATE_FILE \
        --parameters @$PARAMS_FILE

    echo "🎉 Deployment completed"
}

# ================================
# MAIN LOGIC
# ================================
case $OPTION in

    1)
        create_rg
        deploy_infra
        ;;

    2)
        delete_rg
        echo "⏳ Wait for the RG to be deleted and run the script again"
        ;;

    3)
        echo "👋 Exiting..."
        exit 0
        ;;

    *)
        echo "❌ Invalid option"
        ;;
esac
