import React from "react";
import {Page} from "@clumsy_chinchilla/elements";
import {Link} from "@clumsy_chinchilla/elements";
import splash from "./splash.jpg";

export default function LandingPage (): JSX.Element {
  return <Page as="LandingPage">
    <h1>Clumsy Chinchilla</h1>
    <p>
      Cupidatat aliquip exercitation sunt mollit amet laborum tempor. Duis
      elit deserunt cupidatat magna dolor ea sint sunt magna nostrud
      consectetur incididunt ipsum eu. Aliqua mollit labore sint ex
      excepteur duis id labore eiusmod. Velit ex velit nisi ex. Laboris
      deserunt magna aliqua eiusmod excepteur.
    </p>

    <figure id="splash">
      <img src={splash} alt="The ISS floating in the complete emptiness of space" />
    </figure>

    <section id="hero">
      <h1>Henosis</h1>
      <h4>is a better way to <strong>write</strong>, <strong>release</strong>, <strong>manage</strong>, and <strong>observe</strong> Elixir applications above the cloud. You&apos;ll going to like it up here.</h4>

      <section id="call-to-action">
        <Link id="buy" href="/sign-up">Join Us</Link>
        <Link id="use" href="/deploy-henosis">Deploy Henosis</Link>

        <ul>
          {currentAccount === null ? <li><Link href="/sign-up">Sign Up</Link></li> : null}
          {currentAccount === null ? <li><Link href="/login">Login</Link></li> : null}
        </ul>
        <ul>
          {currentAccount === null ? null : <li><Link href="/settings">Settings</Link></li>}
          {currentAccount === null ? null : <li><Link href="/logout">Logout</Link></li>}
        </ul>
      </section>
    </section>

    <hr id="spacer" />

    <section id="pitch">
      <p>
        There&apos;s a lot to keep track of when building applications for a modern workplace. You
        need to make sure to follow best practices, be consistent with your team, test
        the important business logic, and safely deploy only working code (and in the case of
        failure, make sure the customer never sees a problem for long).
      </p>
      <p>
        You don&apos;t have to have a team of two hundred engineers to get there, though. With Henosis you
        leave those hard topics to us, <strong>so you can focus on what matters</strong>.
      </p>
    </section>

    <section id="points">
      <section className="point">
        <figure className="graphic">
          <i className="fas fa-user-astronaut fa-5x" />
        </figure>
        <section className="explination">
          <p>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. <strong>Pellentesque risus mi</strong>, tempus quis placerat ut, porta nec nulla. Vestibulum rhoncus ac ex sit amet fringilla. Nullam gravida purus diam, et dictum felis venenatis efficitur. Aenean ac <em>eleifend lacus</em>, in mollis lectus. Donec sodales, arcu et sollicitudin porttitor, tortor urna tempor ligula, id porttitor mi magna a neque. Donec dui urna, vehicula et sem eget, facilisis sodales sem.
          </p>
        </section>
      </section>
      <section className="point">
        <figure className="graphic">
          <i className="fas fa-satellite fa-5x" />
        </figure>
        <section className="explination">
          <p>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. <strong>Pellentesque risus mi</strong>, tempus quis placerat ut, porta nec nulla. Vestibulum rhoncus ac ex sit amet fringilla. Nullam gravida purus diam, et dictum felis venenatis efficitur. Aenean ac <em>eleifend lacus</em>, in mollis lectus. Donec sodales, arcu et sollicitudin porttitor, tortor urna tempor ligula, id porttitor mi magna a neque. Donec dui urna, vehicula et sem eget, facilisis sodales sem.
          </p>
        </section>
      </section>
      <section className="point">
        <figure className="graphic">
          <i className="fas fa-space-shuttle fa-5x" />
        </figure>
        <section className="explination">
          <p>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. <strong>Pellentesque risus mi</strong>, tempus quis placerat ut, porta nec nulla. Vestibulum rhoncus ac ex sit amet fringilla. Nullam gravida purus diam, et dictum felis venenatis efficitur. Aenean ac <em>eleifend lacus</em>, in mollis lectus. Donec sodales, arcu et sollicitudin porttitor, tortor urna tempor ligula, id porttitor mi magna a neque. Donec dui urna, vehicula et sem eget, facilisis sodales sem.
          </p>
        </section>
      </section>
    </section>
  </Page>;
}
