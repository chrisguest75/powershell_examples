# pull down the pode image
FROM badgerati/pode:latest

# or use the following for GitHub
# FROM docker.pkg.github.com/badgerati/pode/pode:latest

# copy over the local files to the container
COPY ./server.ps1 /usr/src/app/

# expose the port
EXPOSE 8085

# run the server
CMD [ "pwsh", "-c", "cd /usr/src/app; ./server.ps1" ]
