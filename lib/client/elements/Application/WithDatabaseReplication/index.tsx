// import {useRecoilState} from "recoil";
// import {useEffect} from "react";
// import {hidden} from "visibilityjs";

// import {remoteDatabase as remoteDatabaseAtom} from "@clumsy_chinchilla/atoms";
// updateMetadata (currentState, [type, information]) {
//   return mergeDeepRight(currentState)({
//     [type]: {
//       documentCount: information.doc_count,
//       lastCheckedAt: new Date(),
//     },
//   });
// },
// pauseReplication (currentState: {}) {
//   return mergeDeepRight(currentState)({replication: {lastPausedAt: new Date(), incoming: []}});
// },
// resumeReplication (currentState: {}) {
//   return mergeDeepRight(currentState)({replication: {lastStartedAt: new Date()}});
// },
// crashReplication (currentState: {}) {
//   return currentState;
// },
// completeReplication (currentState: {}) {
//   return currentState;
// },
// replicate ({from, to}, {database}) {
//   return dispatch.database.startReplication(
//     database[to].client.replicate.from(database[from].client, REPLICATION_CONFIGURATION)
//       // handle change
//       .on("change", dispatch.database.updateReplication)
//       // replication paused (e.g. replication up to date, user went offline)
//       .on("paused", dispatch.database.pauseReplication)
//       .on("paused", dispatch.database.index)
//       // replicate resumed (e.g. new changes replicating, user went back online)
//       .on("active", dispatch.database.resumeReplication)
//       // a document failed to replicate (e.g. due to permissions)
//       .on("denied", dispatch.database.crashReplication)
//       // handle complete
//       .on("complete", dispatch.database.completeReplication)
//       .on("complete", dispatch.database.index)
//       // handle error
//       .on("error", dispatch.database.crashReplication)
//   );
// },
// async check (type, {database}) {
//   if (hidden()) {
//     return Promise.resolve();
//   }

//   return dispatch.database.updateMetadata([type, await database[type].client.info()]);

const INFO_INTERVAL = 15_000;
const REPLICATION_CONFIGURATION = {
  live: true,
  retry: true,
  heartbeat: true,
  batch_size: 250,
};

interface PropertiesType<C> {
  children: C;
}

export default function WithDatabaseReplication<C> (properties: Readonly<PropertiesType<C>>): C {
  const {children} = properties;
  // const [remoteDatabase, setRemoteDatabase] = useRecoilState<PouchDB.Database | null>(remoteDatabaseAtom);

  // useEffect(() => {
  //   if (!remoteDatabase) {

  //   }
  // }, [remoteDatabase, setRemoteDatabase]);

  return children;
}
