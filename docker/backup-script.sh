DATE=$(date +%Y-%m-%d_%H-%M-%S)
FILE="db-backup-$DATE.tar.gz"
CONTAINER_NAME=mongo

checkMongoContainersCount() {
  count=$(docker ps | grep $CONTAINER_NAME | wc -l)
  if [ "$count" -gt 1 ]; then
    loop
  else
    echo "Found: " $(docker ps | grep $CONTAINER_NAME | awk {'print $1" "$2'} | sed '1q;d')
    createBackup $(docker ps | grep $CONTAINER_NAME | awk {'print $1'} | sed "1q;d")
  fi
}

loop() {
  max=$(docker ps | grep $CONTAINER_NAME | wc -l)

  for (( i=1; i <= $max; ++i ))
  do
    echo "$i) " $(docker ps | grep $CONTAINER_NAME | awk {'print $2'} | sed "${i}q;d")
  done

  read selected_container

  if [ $selected_container -gt 0 ] && [ $selected_container -le $max ]; then
    echo "ya: $(docker ps | grep $CONTAINER_NAME | awk {'print $1'} | sed "${selected_container}q;d")"
    createBackup $(docker ps | grep $CONTAINER_NAME | awk {'print $1'} | sed "${selected_container}q;d")
  else
    echo "Invalid option $selected_container"
  fi
}

listContainers () {
  echo $(docker ps | grep $CONTAINER_NAME | awk {'print $1" "$2'} | sed '$iq;d')
}

createBackup () {
  sudo docker exec -it $1 /bin/bash -c 'rm -rf myTempDbFolder/ \
    && mkdir myTempDbFolder && cd myTempDbFolder/ && mongodump \
    && tar -czvf archive.tar.gz dump/' \
    && copyFromContainer $1
}

copyFromContainer () {
  cd backup \
    && sudo docker cp $1:/myTempDbFolder/archive.tar.gz ./ \
    && mv archive.tar.gz $FILE \
    && deleteTempFilesFromContainer $1
}

deleteTempFilesFromContainer () {
  sudo docker exec -it $1 /bin/bash -c 'rm -rf archive.tar.gz myTempDbFolder/' && echo "Esta feito!"
}

checkMongoContainersCount
#createBackup && copyFromContainer && deleteTempFilesFromContainer && echo "Backup complete!"
