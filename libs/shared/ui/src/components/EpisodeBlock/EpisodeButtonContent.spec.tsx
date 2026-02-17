import React from 'react';
import { render, screen } from '@testing-library/react';
import { make as EpisodeButtonContent } from './EpisodeButtonContent.bs.mjs';

describe('EpisodeButtonContent', () => {
  it('renders the title', () => {
    render(<EpisodeButtonContent title="Episode 1" />);
    expect(screen.getByText('Episode 1')).toBeTruthy();
  });

  it('renders the duration when provided', () => {
    render(<EpisodeButtonContent title="Episode 1" duration="45 min" />);
    expect(screen.getByText('45 min')).toBeTruthy();
  });

  it('does not render duration when undefined', () => {
    render(<EpisodeButtonContent title="Episode 1" />);
    expect(screen.queryByText('45 min')).toBeNull();
  });

  it('renders the description when provided', () => {
    render(
      <EpisodeButtonContent title="Episode 1" description="A great episode" />
    );
    expect(screen.getByText('A great episode')).toBeTruthy();
  });

  it('does not render description when undefined', () => {
    render(<EpisodeButtonContent title="Episode 1" />);
    expect(screen.queryByText('A great episode')).toBeNull();
  });

  it('renders all props together', () => {
    render(
      <EpisodeButtonContent
        title="Episode 1"
        duration="45 min"
        description="A great episode"
      />
    );
    expect(screen.getByText('Episode 1')).toBeTruthy();
    expect(screen.getByText('45 min')).toBeTruthy();
    expect(screen.getByText('A great episode')).toBeTruthy();
  });
});
