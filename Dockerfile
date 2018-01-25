FROM scratch

ADD rosalie rosalie

EXPOSE 8080

CMD ["rosalie"]