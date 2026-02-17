import React from 'react';
import { render, screen } from '@testing-library/react';
import { make as EpisodeCard } from './EpisodeCard.bs.mjs';

describe('EpisodeCard', () => {
  const defaultProps = {
    src: 'https://example.com/image.jpg',
    alt: 'Episode thumbnail',
  };

  it('renders an image with correct src and alt', () => {
    render(<EpisodeCard {...defaultProps} />);
    const img = screen.getByRole('img');
    expect(img).toBeTruthy();
    expect(img.getAttribute('src')).toBe('https://example.com/image.jpg');
    expect(img.getAttribute('alt')).toBe('Episode thumbnail');
  });

  it('renders image with loading="lazy"', () => {
    render(<EpisodeCard {...defaultProps} />);
    const img = screen.getByRole('img');
    expect(img.getAttribute('loading')).toBe('lazy');
  });

  it('does not render overlay when hover is false (default)', () => {
    const { container } = render(<EpisodeCard {...defaultProps} />);
    const svgs = container.querySelectorAll('svg');
    expect(svgs.length).toBe(0);
  });

  it('renders overlay when hover is true', () => {
    const { container } = render(<EpisodeCard {...defaultProps} hover={true} />);
    const svgs = container.querySelectorAll('svg');
    expect(svgs.length).toBeGreaterThan(0);
  });
});
