FROM scratch

COPY rosalie rosalie

EXPOSE 4000

CMD ["/rosalie"]
