FROM scratch

COPY rosalie rosalie

ENV PORT=8080

EXPOSE 8080

CMD ["/rosalie"]
