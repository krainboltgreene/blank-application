import type {ReactNode} from "react";
import {useRecoilState} from "recoil";
import {useEffect} from "react";

import PouchDB from "pouchdb";
import {localDatabase as localDatabaseAtom} from "@clumsy_chinchilla/atoms";

const LOCAL_DATABASE_CONFIGURATION = {
  auto_compaction: true,
};

interface PropertiesType {
  children: ReactNode;
}

export default function WithLocalDatabase (properties: Readonly<PropertiesType>): ReactNode {
  const {children} = properties;
  const [localDatabase, setLocalDatabase] = useRecoilState<PouchDB.Database | null>(localDatabaseAtom);

  useEffect(() => {
    if (!localDatabase) {
      setLocalDatabase(new PouchDB("local", LOCAL_DATABASE_CONFIGURATION));
    }
  }, [localDatabase, setLocalDatabase]);

  return children;
}
