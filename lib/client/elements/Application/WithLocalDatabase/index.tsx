import {useRecoilState} from "recoil";
import {useEffect} from "react";

import PouchDB from "pouchdb";
import pouchDBQuickSearch from "pouchdb-quick-search";
import pouchDBAdapterMemory from "pouchdb-adapter-memory";
import {localDatabase as localDatabaseAtom} from "@clumsy_chinchilla/atoms";

PouchDB.plugin(pouchDBQuickSearch);
PouchDB.plugin(pouchDBAdapterMemory);

const LOCAL_DATABASE_CONFIGURATION = {
  auto_compaction: true,
};

export default function WithLocalDatabase (properties) {
  const {children} = properties;
  const [localDatabase, setLocalDatabase] = useRecoilState(localDatabaseAtom);

  useEffect(() => {
    if (!localDatabase) {
      setLocalDatabase(new PouchDB("local", LOCAL_DATABASE_CONFIGURATION));
    }
  }, [localDatabase, setLocalDatabase]);

  return children;
}
