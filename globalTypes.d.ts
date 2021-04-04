/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

//==============================================================
// START Enums and Input Objects
//==============================================================

export interface AccountChangeset {
  readonly id: string;
  readonly username?: string | null;
  readonly emailAddress?: string | null;
  readonly password?: string | null;
}

export interface AccountConfirmation {
  readonly confirmationSecret: string;
  readonly password: string;
}

export interface Identity {
  readonly id: string;
}

export interface NewAccount {
  readonly username?: string | null;
  readonly emailAddress: string;
  readonly password?: string | null;
}

export interface NewSession {
  readonly emailAddress: string;
  readonly password: string;
}

export interface ProfileChangeset {
  readonly id: string;
  readonly publicName?: string | null;
}

export interface SettingsChangeset {
  readonly id: string;
  readonly lightMode?: boolean | null;
}

//==============================================================
// END Enums and Input Objects
//==============================================================
