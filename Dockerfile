#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 5000

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["doc-application.csproj", "."]
RUN dotnet restore "./doc-application.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "doc-application.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "doc-application.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "doc-application.dll"]
