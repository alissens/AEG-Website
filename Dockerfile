# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /AEGBuilders

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out 

# Build runtime image
FROM build
WORKDIR /AEGBuilders
COPY --from=build /AEGBuilders/out .
ENTRYPOINT ["dotnet", "AEGBuilders.dll"]
