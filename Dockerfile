FROM scratch

COPY rosalie rosalie

EXPOSE 8080

CMD ["/rosalie"]
