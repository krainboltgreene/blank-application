/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

//==============================================================
// START Enums and Input Objects
//==============================================================

export interface AccountConfirmation {
  readonly confirmationSecret: string;
  readonly password: string;
}

export interface NewAccount {
  readonly emailAddress: string;
  readonly name?: string | null;
  readonly password?: string | null;
  readonly username?: string | null;
}

export interface NewSession {
  readonly emailAddress: string;
  readonly password: string;
}

export interface SettingsChangeset {
  readonly id: string;
  readonly lightMode?: boolean | null;
}

//==============================================================
// END Enums and Input Objects
//==============================================================
