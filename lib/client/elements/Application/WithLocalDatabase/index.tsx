import {useRecoilState} from "recoil";
import {useEffect} from "react";
// import {hidden} from "visibilityjs";

import PouchDB from "pouchdb";
import {localDatabase as localDatabaseAtom} from "@clumsy_chinchilla/atoms";
// updateSearchMetadata (currentState, payload) {
//   return mergeDeepRight(currentState)({search: payload});
// },
// toggleSearching (currentState: {active: boolean}) {
//   return mergeDeepRight(currentState)({
//     search: {active: !currentState.active},
//   });
// },
// async search ([query, fields], {database}) {
//   dispatch.database.toggleSearching();
//   dispatch.database.updateSearchMetadata({query});

//   const results = await database.local.client.search({
//     query,
//     fields,
//     include_docs: true,
//   });

//   dispatch.database.toggleSearching();
//   dispatch.database.updateSearchMetadata({count: results.total_rows});

//   return results;
// },
// async index (_nothing, {database}) {
//   await database.local.client.search({
//     fields: ["words"],
//     build: true,
//   });
//   await database.local.client.search({
//     fields: ["definitions.detail"],
//     build: true,
//   });
//   await database.local.client.search({
//     fields: ["words", "definitions.detail"],
//     build: true,
//   });
// },
// getEntry (id, {database}) {
//   return database.local.client.get(id);
// },
const LOCAL_DATABASE_CONFIGURATION = {
  auto_compaction: true,
};

interface PropertiesType<C> {
  children: C;
}

export default function WithLocalDatabase<C> (properties: Readonly<PropertiesType<C>>): C {
  const {children} = properties;
  const [localDatabase, setLocalDatabase] = useRecoilState<PouchDB.Database | null>(localDatabaseAtom);

  useEffect(() => {
    if (!localDatabase) {
      setLocalDatabase(new PouchDB("local", LOCAL_DATABASE_CONFIGURATION));
    }
  }, [localDatabase, setLocalDatabase]);

  return children;
}
