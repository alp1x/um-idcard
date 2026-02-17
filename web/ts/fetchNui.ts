const resource = (window as any).GetParentResourceName?.() ?? 'nui-frame-app';

export const fetchNui = async <T = unknown>(eventName: string, data?: unknown): Promise<T | undefined> => {
  try {
    const res = await fetch(`https://${resource}/${eventName}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json; charset=UTF-8' },
      body: JSON.stringify(data),
    });
    return await res.json() as T;
  } catch (err) {
    console.error(err);
  }
};
