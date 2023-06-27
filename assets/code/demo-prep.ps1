# Publish the application
dotnet publish -c Release --framework net7.0 

# Build container
docker build -t throughput-test-image -f Dockerfile .

# Single run locally
docker run -it --rm throughput-test-image -C "<service-bus-connection-string>" -S queue-defaults

# Switch Azure subscription
az account set --subscription "<subscription-name>"

# Login to ACR
az acr login --name acreldertpgperformancetest 

# Tag image for upload to ACR
docker tag throughput-test-image acreldertpgperformancetest.azurecr.io/throughput-test-image:dev    

# Push image to ACR
docker push acreldertpgperformancetest.azurecr.io/throughput-test-image:dev

# Show container in ACR
az acr repository list --name acreldertpgperformancetest --output table