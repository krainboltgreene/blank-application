import {useRecoilState} from "recoil";
import {useEffect} from "react";
// import {hidden} from "visibilityjs";

import PouchDB from "pouchdb";
import {remoteDatabase as remoteDatabaseAtom} from "@clumsy_chinchilla/atoms";


const {env} = process;
const {REMOTE_DATABASE_URI} = env;
const {REMOTE_DATABASE_USERNAME} = env;
const {REMOTE_DATABASE_PASSWORD} = env;
const REMOTE_DATABASE_CONFIGURATION = {
  auto_compaction: true,
  auth: {
    username: REMOTE_DATABASE_USERNAME,
    password: REMOTE_DATABASE_PASSWORD,
  },
};

interface PropertiesType<C> {
  children: C;
}

export default function WithRemoteDatabase<C> (properties: Readonly<PropertiesType<C>>): C {
  const {children} = properties;
  const [remoteDatabase, setRemoteDatabase] = useRecoilState<PouchDB.Database | null>(remoteDatabaseAtom);

  useEffect(() => {
    if (!remoteDatabase) {
      setRemoteDatabase(new PouchDB(REMOTE_DATABASE_URI, REMOTE_DATABASE_CONFIGURATION));
    }
  }, [remoteDatabase, setRemoteDatabase]);

  return children;
}
