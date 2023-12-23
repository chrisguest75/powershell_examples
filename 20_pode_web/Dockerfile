# pull down the pode image
FROM badgerati/pode.web:latest

# or use the following for GitHub
# FROM docker.pkg.github.com/badgerati/pode.web/pode.web:latest

# copy over the local files to the container
COPY ./server.ps1 /usr/src/app/
COPY ./pages /usr/src/app/pages

# expose the port
EXPOSE 8080

# run the server
CMD [ "pwsh", "-c", "cd /usr/src/app; ./server.ps1" ]
